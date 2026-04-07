#!/usr/bin/env python3
"""
Script to build all smoke test Dockerfiles and log failures.
This script will execute the build script on all smoke directories
and save any failures to err.log.
"""

import os
import subprocess
import sys
from pathlib import Path

def run_build_script(directory):
    """Run the build script on a given directory."""
    try:
        # Get absolute path of the build script
        script_dir = Path(__file__).parent.absolute()
        build_script_path = script_dir / "build"
        
        # Run build script directly 
        result = subprocess.run([
            str(build_script_path), 
            str(directory)
        ], capture_output=True, text=True, timeout=900)  # 15 minutes timeout
        
        return result.returncode == 0, result.stdout, result.stderr
    except subprocess.TimeoutExpired:
        return False, "", "Timeout occurred (15 minutes exceeded)"
    except Exception as e:
        return False, "", str(e)

def main():
    """Main function to process all smoke directories."""
    script_dir = Path(__file__).parent
    repo_root = script_dir.parent
    
    # Delete existing err.log if it exists
    err_log = repo_root / "err.log"
    if err_log.exists():
        err_log.unlink()
    
    # Find all smoke directories
    smoke_dirs = list(repo_root.glob("**/smoke"))
    
    if not smoke_dirs:
        print("No smoke directories found!")
        return 1
    
    print(f"Found {len(smoke_dirs)} smoke directories")
    
    failures = []
    
    # Process each smoke directory
    for smoke_dir in smoke_dirs:
        print(f"\nProcessing: {smoke_dir}")
        
        # Check if Dockerfile exists
        dockerfile = smoke_dir / "Dockerfile"
        if not dockerfile.exists():
            print(f"  WARNING: No Dockerfile found in {smoke_dir}")
            failures.append({
                'directory': str(smoke_dir),
                'error': 'No Dockerfile found'
            })
            continue
            
        # Run the build
        success, stdout, stderr = run_build_script(smoke_dir)
        
        if success:
            print(f"  SUCCESS: Built successfully")
        else:
            print(f"  FAILED: Build failed - {stderr or stdout}")
            failures.append({
                'directory': str(smoke_dir),
                'stdout': stdout,
                'stderr': stderr
            })
    
    # Write failures to err.log
    if failures:
        with open(repo_root / "err.log", "w") as f:
            f.write("Smoke build failures:\n")
            f.write("=" * 50 + "\n")
            for failure in failures:
                f.write(f"Directory: {failure['directory']}\n")
                if 'stdout' in failure and failure['stdout']:
                    f.write(f"Stdout: {failure['stdout']}\n")
                if 'stderr' in failure and failure['stderr']:
                    f.write(f"Stderr: {failure['stderr']}\n")
                f.write("-" * 50 + "\n")
        
        print(f"\nFailed builds logged to err.log ({len(failures)} failures)")
        return 1
    else:
        print("\nAll smoke tests built successfully!")
        # Remove err.log if it exists and there are no failures
        if err_log.exists():
            err_log.unlink()
        return 0

if __name__ == "__main__":
    sys.exit(main())