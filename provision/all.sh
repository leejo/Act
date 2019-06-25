#!/bin/bash

# Execute all the scripts in a directory.
function exec_dir () {
  local dir="$1"
  [[ "${dir:0:1}" == "/" ]] || dir="/vagrant/provision/$dir"
  for exe in "$dir"/*; do
    test -x "$exe" && echo "# $exe" && "$exe"
  done
}

# Execute any before vm initialization scripts.
exec_dir before

# Execute any after vm clean-up scripts.
exec_dir after

# install CPAN dependencies, note we are using the system perl here...
cd /home/vagrant/act
PERL_MM_USE_DEFAULT=1 cpan App::cpanminus
cpanm --installdeps .

# database setup (note this is DEV setup hence simple passwords)

# Don't let vagrant think the provision failed.
exit 0
