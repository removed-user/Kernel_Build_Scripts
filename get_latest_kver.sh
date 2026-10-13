#!/usr/bin/env bash
function select_version() {
function fetch_cmd() {
	function curl_cmd() {
curl -# -C -  $@ -O
	}

	function wget_cmd() {
wget $@ -O 
	}
		if $(which -as curl); then FETCHER=curl_cmd; elif $(which -as wget); then FETCHER=wget_cmd; else echo 'No Fetcher (curl/wget)';fi
"${FETCHER}" $@
	}
function print_versions() {
[[ ! -f /tmp/kver ]] && curl -s https://www.kernel.org/finger_banner > /tmp/kver
		sed -n '1,2p; 4p' /tmp/kver | awk -F ' ' '{print $3"=" $NF}' |\
		sed -e 's#=#&"#g' -e 's#$#"#g'
} 
eval $(print_versions)
# print_versions
if [[ ! -z $PICK_VERSION ]]; then
PS3="Select Kernel version to copy locally: "
echo 'Mainline:          (MNL):' "${mainline}"
echo 'Stable:            (STB):' "${stable}"
echo 'Long_Term_Support: (LTS):' "${longterm}"

options=("MNL" "STB" "LTS")
select choice in "${options[@]}"; do
    case $choice in
        "MNL"|1)
            echo "Selecting: MNL ${mainline}"
SELECTED=${mainline}
local FETCH_URL="https://git.kernel.org/torvalds/t/linux-"${SELECTED}".tar.gz"
            break
            ;;
        "STB"|2)
            echo "Selecting: STB ${stable}"
SELECTED=${stable}
local FETCH_URL="https://cdn.kernel.org/pub/linux/kernel/v"${SELECTED:0:1}".x/linux-"${SELECTED}".tar.xz"
            break
            ;;
        "LTS"|3)
            echo "Selecting: LTS ${longterm}"
SELECTED=${longterm}
local FETCH_URL="https://cdn.kernel.org/pub/linux/kernel/v"${SELECTED:0:1}".x/linux-"${SELECTED}".tar.xz"
            break
            ;;
        *)
echo 'Invalid Option:'
echo -e "Defaulting to LTS build:\n\tLatest_Stable=${longterm}"
	    break
            ;;
esac
done
else
echo -e "Defaulting to LTS build:\n\tLatest_Stable=${longterm}"
fi

fetch_cmd "${FETCH_URL}"
}
select_version

