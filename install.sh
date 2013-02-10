#!/bin/sh
set -e -x

# installer for samtools
#
# create your base folder
mkdir -p /opt/samtools
cd /opt/samtools
# do the work
wget http://sourceforge.net/projects/samtools/files/samtools/0.1.18/samtools-0.1.18.tar.bz2/download
tar --bzip2 -xf samtools-0.1.18.tar.bz2
cd samtools-0.1.18
# stupid dependency
yum -y install ncurses*
yum -y install zlib*
# lcurses not there, use the new one lncurses
sed -i -e "s/-lcurses/-lncurses/g" Makefile
make
make razip

# copy libs
cp libbam.a /usr/local/lib
mkdir -p /usr/local/include/bam
cp *.h /usr/local/include/bam

# copy bins
cp samtools /usr/local/
cp samtools /usr/bin/
cp ./bcftools/bcftools /usr/bin/
cp ./bcftools/vcfutils.pl /usr/bin/
cp ./misc/*.pl /usr/bin
cp ./misc/maq2sam-* /usr/bin


