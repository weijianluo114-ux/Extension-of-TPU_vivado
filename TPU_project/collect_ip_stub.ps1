# ================================
# Collect Vivado IP stub files
# ================================

# Vivado 工程路径（改成你的）
$vivado_dir = "vivado/TPU1.0"

# 输出目录
$output_dir = "ip_stub"

# 创建输出目录（如果不存在）
if (!(Test-Path $output_dir)) {
    New-Item -ItemType Directory -Path $output_dir | Out-Null
}

Write-Host "Searching for *_stub.v files..."

# 查找所有 stub 文件
$stub_files = Get-ChildItem -Path $vivado_dir -Recurse -Filter "*_stub.v" -ErrorAction SilentlyContinue

if ($stub_files.Count -eq 0) {
    Write-Host "No stub files found!" -ForegroundColor Yellow
    exit
}

# 复制文件
foreach ($file in $stub_files) {
    $dest = Join-Path $output_dir $file.Name
    Copy-Item $file.FullName $dest -Force
    Write-Host "Copied: $($file.Name)"
}

Write-Host "Done! All stub files are in $output_dir" -ForegroundColor Green