import re
import subprocess

# Get the output of the git lfs ls-files -s command
def get_lfs_files():
    result = subprocess.run(['git', 'lfs', 'ls-files', '-s'], capture_output=True, text=True)
    return result.stdout.strip().split('\n')

# Convert human-readable sizes to bytes
def size_to_bytes(size_str):
    size, unit = size_str.split()
    size = float(size)
    if unit == 'KB':
        return int(size * 1024)
    elif unit == 'MB':
        return int(size * 1024 * 1024)
    elif unit == 'GB':
        return int(size * 1024 * 1024 * 1024)
    return int(size)

# Parse the LFS output and sort by size
lfs_files = get_lfs_files()
file_info = []
for line in lfs_files:
    match = re.search(r'(.*) \((.*?)\)$', line)
    if match:
        file_path = match.group(1)
        size_str = match.group(2)
        size_bytes = size_to_bytes(size_str)
        file_info.append((size_bytes, file_path, size_str))

# Sort the files by size (largest first)
file_info.sort(key=lambda x: x[0], reverse=True)

# Print the sorted list
for size_bytes, file_path, size_str in file_info:
    print(f"{file_path} ({size_str})")
