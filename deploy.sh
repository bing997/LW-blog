#!/bin/bash

# Hexo 博客部署脚本（GitHub Pages）
# 用法：./deploy.sh

echo "=========================================="
echo " Hexo 博客部署脚本（GitHub Pages）"
echo "=========================================="
echo ""

# 清理缓存和旧文件
echo "[1/4] 正在清理缓存..."
npx hexo clean
if [ $? -ne 0 ]; then
    echo "[错误] 清理失败！"
    exit 1
fi

# 生成静态文件（使用部署配置）
echo ""
echo "[2/4] 正在生成静态文件..."
npx hexo generate --config _config.yml,_config.deploy.yml
if [ $? -ne 0 ]; then
    echo "[错误] 生成失败！"
    exit 1
fi

# 部署到 GitHub Pages
echo ""
echo "[3/4] 正在部署到 GitHub Pages..."
npx hexo deploy --config _config.yml,_config.deploy.yml
if [ $? -ne 0 ]; then
    echo "[错误] 部署失败！"
    exit 1
fi

# 部署完成
echo ""
echo "[4/4] 部署完成！"
echo ""
echo "=========================================="
echo " 部署成功！"
echo " 访问地址：https://bing997.github.io/LW-blog/"
echo "=========================================="
