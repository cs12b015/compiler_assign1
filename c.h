void addtoarray(char *a,char *b,char *c){

    if(strcmp(b,"friendof")== 0){
    	 strcpy(friend1[friendsize],a);
    	 strcpy(friend2[friendsize],c);
    	 friendsize++;
    }else if (strcmp(b,"roommateof")== 0){
    	 strcpy(roommate1[roommatesize],a);
    	 strcpy(roommate2[roommatesize],c);
    	 roommatesize++;
    }else if (strcmp(b,"classmateof")== 0){
    	 strcpy(classmate1[classmatesize],a);
    	 strcpy(classmate2[classmatesize],c);
    	 classmatesize++;
    }
}

void print_the_array(){
	printf("friend1\n[");
	int i;
	for( i=0;i<friendsize;i++){
		printf(" %s ",friend1[i]);
	}
	printf("]\n");
	printf("friend2\n[");
	for( i=0;i<friendsize;i++){
		printf(" %s ",friend2[i]);
	}
	printf("]\n");
	printf("roommate1\n[");
	for( i=0;i<roommatesize;i++){
		printf(" %s ",roommate1[i]);
	}
	printf("]\n");
	printf("roommate2\n[");
	for( i=0;i<roommatesize;i++){
		printf(" %s ",roommate2[i]);
	}
	printf("]\n");
	printf("classmate1\n[");
	for( i=0;i<classmatesize;i++){
		printf(" %s ",classmate1[i]);
	}
	printf("]\n");
	printf("classmate2\n[");
	for( i=0;i<classmatesize;i++){
		printf(" %s ",classmate2[i]);
	}
	printf("]\n");
}