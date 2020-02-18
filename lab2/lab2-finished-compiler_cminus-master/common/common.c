#include "common.h"
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <dirent.h>
#include <unistd.h>
#include<string.h>

int getAllTestcase(char filename[][256]){
	int files_count=0;
	DIR * dir;
    	struct dirent * ptr;
	dir = opendir("./testcase/"); //
	while((ptr = readdir(dir)) != NULL){
		if(strstr(ptr->d_name,".cminus")){
			files_count ++;
			strcpy(filename[files_count - 1],ptr->d_name);
		}
	}
		
	return files_count;
}

