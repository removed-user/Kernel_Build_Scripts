#!/usr/bin/env bash
function select_version() {
function print_versions()
{
[[ ! -f /tmp/kver ]] && curl -s https://www.kernel.org/finger_banner > /tmp/kver
sed -n '1,2p; 4p' /tmp/kver | awk -F ' ' '{print $3"=" $NF}' |\
sed -e 's#=#&"#g' -e 's#$#"#g'
}
print_versions

}

