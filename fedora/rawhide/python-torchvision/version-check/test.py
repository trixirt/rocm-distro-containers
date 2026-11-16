#!/usr/bin/env python3
import importlib.util
import sys


def main():
    failures = []

    def check(name, fn):
        try:
            fn()
            print(f"PASS: {name}")
        except Exception as e:
            failures.append(name)
            print(f"FAIL: {name}: {type(e).__name__}: {e}")

    import torch
    print(f"torch {torch.__version__} "
          f"(version.hip={torch.version.hip!r}, version.cuda={torch.version.cuda!r})")

    def t1():
        import torchvision
        print(f"  torchvision {torchvision.__version__} imported OK")
    check("import torchvision", t1)

    def t2():
        v = torch.ops.torchvision._cuda_version()
        assert isinstance(v, int), f"expected int, got {type(v).__name__}"
        assert v == -1 or v > 0, f"unexpected version value {v}"
        note = (" (no accelerator libs compiled in — expected -1 in the Koji build)"
                if v == -1 else "")
        print(f"  torchvision::_cuda_version() = {v}{note}")
    check("torchvision::_cuda_version op is registered", t2)

    def t3():
        from torchvision.ops import nms
        boxes = torch.tensor([[0.0, 0.0, 1.0, 1.0],
                              [0.5, 0.5, 2.0, 2.0],
                              [0.6, 0.6, 2.1, 2.1]])
        scores = torch.tensor([0.9, 0.8, 0.7])
        keep = nms(boxes, scores, 0.5)
        assert keep.numel() == 2, f"unexpected nms result {keep.tolist()}"
        print(f"  nms(3 boxes, iou=0.5) kept {keep.tolist()}")
    check("C extension functional (torchvision.ops.nms on CPU)", t3)

    if importlib.util.find_spec("transformers") is None:
        print("SKIP: transformers not installed (vllm-chain check needs it)")
    else:
        def t4():
            import transformers
            import transformers.image_utils
            if "torchvision" in sys.modules:
                print(f"  transformers {transformers.__version__}: image_utils "
                      "imported torchvision through the vllm chain — OK")
            else:
                print(f"  transformers {transformers.__version__}: image_utils "
                      "did not import torchvision (upstream guard active) — OK")
        check("vllm import chain (transformers.image_utils -> torchvision)", t4)

    print()
    if failures:
        print(f"RESULT: FAIL ({len(failures)} failed: {failures})")
        return 1
    print("RESULT: PASS")
    return 0


if __name__ == "__main__":
    sys.exit(main())
