/*  <=-*- C -*-=>  */

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include <sys/types.h>
#include <dirent.h>
#include <stdio.h>

MODULE = ReadDir		PACKAGE = ReadDir		

void
readdir_inode(dirname)
     char*    dirname
INIT:
  struct dirent *ent;
  DIR* dir;
  SV* record[2];
  AV *entry, *ret_val;
PPCODE:
  dir = opendir(dirname);
  if (dir) {
    while ((ent=readdir(dir))) {
      record[0] = newSVpv(ent->d_name, 0);
      record[1] = newSViv((IV)ent->d_ino);
      PUSHs(sv_2mortal(newRV_inc((SV*)av_make(2, record))));
    }
    closedir(dir);
  }
