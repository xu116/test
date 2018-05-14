#!/bin/sh

echo $TOPDIR
if [ "$TOPDIR" = "" ]; then 
	echo "please source first"
	exit 1 
fi
if [ "$1" = "" ];then
	echo "no param 1"
	exit 1
fi
echo $1
echo $TOPDIR
build_dir=$TOPDIR/build 
if [ ! -d $build_dir/rootfs/ ]; then 
	echo "not a dir $build_dir" 
	exit 1 
fi

#install_sh=$TOPDIR/tools/install.sh
src=$TOPDIR/src/ugw
tools=$TOPDIR/tools/
cp $src $build_dir/rootfs/ -r
#cp $tools $build_dir/rootfs/ -r
cd $build_dir

#ghw add svn version info
version=`svn info | grep Revision | cut -d " " -f 2`
password=wjrc0409
#version=1.0
outfile=$1"-forum-`date +%Y%m%d%H%M%S`-"$version
echo $outfile
echo $build_dir
echo -n $outfile > $build_dir/rootfs/version
openssl_tar=$TOPDIR/tools/openssltar.sh
echo $openssl_tar
$openssl_tar tar $build_dir/rootfs $build_dir/$outfile wjrc0409
if [ $? -ne 0 ]; then 
	echo "make package $outfile fail"
	exit 1
fi 
echo "make package $outfile ok"
