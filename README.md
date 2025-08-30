# raspios

Quick and dirty OCI container for Raspberry Pi OS Lite armhf, suitable for
Raspberry Pi 1 and Zero or Zero W.

It's pretty rough since the build uses 7-zip to extract the ext4 filesystem,
which doesn't preserve file ownership or permissions. But it's probably good
enough for basic use such as building binaries targeting Raspberry Pi OS
from source code.

The container build essentially downloads the microSD card image from the
website, unpacks it, works out the offset where the ext4 filesystem begins
within the image, extracts that out of the microSD card image, then extracts
the files within it using 7-zip. It then uses those files as the basis for the
final image.

Don't expect this to work for all cases. I built it so I could do much faster
native-project builds targeting Raspberry Pi OS for a Raspberry Pi Zero with
its weird ARMv6 + VFP architecture. It'd be handy on the Ampere Altra-based
"always free" generously sized (24 GiB RAM, 4 ARMv8 Neoverse-N1 cores) cloud
instances that Super Libertarian Larry offers on Larry Cloud.
