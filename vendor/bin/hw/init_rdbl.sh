#!/vendor/bin/sh

#
# upgrade recovery DBL image for current slot
#

# Log messages to both logcat and the shell
LOG_TAG=init_rdbl

log_info() {
    log -p i -t "${LOG_TAG}" "$1"
    echo "$1" >&2
}

log_error() {
    log -p e -t "${LOG_TAG}" "$1"
    echo "$1" >&2
}

# lookup recovery DBL variant
rdbl_src=/vendor/firmware/rdbl.img
rdbl_dst=/dev/block/by-name/rdbl

log_info "rdbl_src:$rdbl_src"
log_info "rdbl_dst:$rdbl_dst"

[ ! -r "$rdbl_src" ] && log_info "SRC rDBL is not readable. Bail out." && exit
[ ! -w "$rdbl_dst" ] && log_info "DST rDBL is not writable. Bail out." && exit

log_info "recovery DBL is being replaced."
# TODO(b/404680156): avoid updating rDBL image if the incoming version is the same
cp $rdbl_src $rdbl_dst
