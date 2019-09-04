PATCH_LIST=patch.list

for x in $(cat $PATCH_LIST); do
    if git cherry-pick $x; then
        sed -i "/$x/d" $PATCH_LIST
        echo "[*] Successfully cherry-pick'ed $x (removed from $PATCH_LIST)"
    else
        echo "[*] Failed to cherry-pick $x"
        echo "[*] Please manual resolve conflict and remove first line in $PATCH_LIST"
        break
    fi
done

