#!/bin/bash

# Cron job management script

CRON_JOB="*/5 * * * * /workdir/.vscode/auto-commit.sh >> /workdir/.vscode/.auto-commit.log 2>&1"
CRON_JOB_NO_PUSH="*/5 * * * * /workdir/.vscode/auto-commit.sh --no-push >> /workdir/.vscode/.auto-commit.log 2>&1"
STATE_FILE="/root/.cron-state"

case "$1" in
    start)
        echo "Cronジョブを開始中...（自動pushあり）"
        (crontab -l 2>/dev/null | grep -v "auto-commit.sh"; echo "$CRON_JOB") | crontab -
        echo "running" > "$STATE_FILE"
        echo "✓ Cronジョブが開始されました（5分ごと、自動push有効）"
        crontab -l | grep auto-commit
        ;;
    start-no-push)
        echo "Cronジョブを開始中...（自動pushなし）"
        (crontab -l 2>/dev/null | grep -v "auto-commit.sh"; echo "$CRON_JOB_NO_PUSH") | crontab -
        echo "running-no-push" > "$STATE_FILE"
        echo "✓ Cronジョブが開始されました（5分ごと、自動push無効）"
        crontab -l | grep auto-commit
        ;;
    stop)
        echo "Cronジョブを停止中..."
        crontab -l 2>/dev/null | grep -v "auto-commit.sh" | crontab -
        echo "stopped" > "$STATE_FILE"
        echo "✓ Cronジョブが停止されました"
        ;;
    status)
        if crontab -l 2>/dev/null | grep -q "auto-commit.sh"; then
            echo "🟢 Cronジョブ: 実行中"
            crontab -l | grep auto-commit
        else
            echo "🔴 Cronジョブ: 停止中"
        fi
        ;;
    *)
        echo "使用方法: $0 {start|start-no-push|stop|status}"
        echo ""
        echo "コマンド:"
        echo "  start          - 5分ごとの自動commit＋push を開始"
        echo "  start-no-push  - 5分ごとの自動commit（pushなし）を開始"
        echo "  stop           - 自動commitを停止"
        echo "  status         - 実行状態を確認"
        exit 1
        ;;
esac

exit 0
