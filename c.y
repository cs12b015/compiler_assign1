%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>



    int errorbit=0;
    int yylex(void);
    void yyerror(char *);
    int roommatesize=0;
    int friendsize=0;
    int classmatesize=0;
    char **roommate1;
    char **roommate2;
    char **classmate1;
    char **classmate2;
    char **friend1;
    char **friend2;

    void addtoarray(char *a,char *b,char *c);
    void checkclassmates();

%}

%union{
    char *strng;
};

%token <strng> ENDFOREACH
%token <strng> IF
%token <strng> RELATIONSHIP
%token <strng> ENDIF 
%token <strng> FOREACH
%token <strng> NAME
%token <strng> VARIABLE 

%type <strng> instructions expression program


%%

program       :        instructions{
                        int len=11;
                        len+=strlen($1);
                        char* stringg=(char*)malloc((sizeof (char)* len)+1);
                        sprintf(stringg,"graph\n{\n%s}\n",$1);
                        $$ = strdup(stringg);
                        //printf("%s",$$);
                        
                    };


instructions    :   instructions expression   { 
                        int len=0;
                        len+=strlen($1);
                        len+=strlen($2);
                        char* stringg=(char*)malloc((sizeof (char)* len)+1);
                        sprintf(stringg,"%s%s",$1,$2);
                        $$ = strdup(stringg);
                    }
                |   {$$ = "";}
                ;

expression   :   NAME RELATIONSHIP NAME {
                        int len=16;
                        len+=strlen($1);
                        len+=strlen($2);
                        len+=strlen($3);
                        addtoarray($1,$2,$3);
                        char* stringg=(char*)malloc((sizeof (char)* len)+1);
                        sprintf(stringg,"%s -- %s [label=\"%s\"]\n",$1,$3,$2); 
                        $$ = strdup(stringg);

                        
                    };


%%

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

void checkclassmates(){
    int i,j;
    int tempclassmatesize=classmatesize;
    for(i=0;i<tempclassmatesize;i++){
        for(j=i;j<tempclassmatesize;j++){
	        if(i==j){}
	        else{
	            if(strcmp(classmate1[i],classmate1[j])==0){
	                strcpy(classmate1[classmatesize],classmate2[i]);
	                strcpy(classmate2[classmatesize],classmate2[j]);
	                classmatesize++;
	            }else if(strcmp(classmate1[i],classmate2[j])==0){
	               strcpy(classmate1[classmatesize],classmate2[i]);
	               strcpy(classmate2[classmatesize],classmate1[j]);
	                classmatesize++;                
	            }else if(strcmp(classmate2[i],classmate2[j])==0){
	                strcpy(classmate1[classmatesize],classmate1[i]);
	                strcpy(classmate2[classmatesize],classmate1[j]);
	                classmatesize++;
	            }else if(strcmp(classmate2[i],classmate1[j])==0){
	                strcpy(classmate1[classmatesize],classmate1[i]);
	                strcpy(classmate2[classmatesize],classmate2[j]);
	                classmatesize++;
	            }
	        }	       
        }
    }
}

void checkroommates(){
    int i,j;
    int temproommatesize=roommatesize;
    for(i=0;i<temproommatesize;i++){
        for(j=i;j<temproommatesize;j++){
	        if(i==j){}
	        else{
	            if(strcmp(roommate1[i],roommate1[j])==0){
	                strcpy(roommate1[roommatesize],roommate2[i]);
	                strcpy(roommate2[roommatesize],roommate2[j]);
	                roommatesize++;
	            }else if(strcmp(roommate1[i],roommate2[j])==0){
	               strcpy(roommate1[roommatesize],roommate2[i]);
	               strcpy(roommate2[roommatesize],roommate1[j]);
	                roommatesize++;                
	            }else if(strcmp(roommate2[i],roommate2[j])==0){
	                strcpy(roommate1[roommatesize],roommate1[i]);
	                strcpy(roommate2[roommatesize],roommate1[j]);
	                roommatesize++;
	            }else if(strcmp(roommate2[i],roommate1[j])==0){
	                strcpy(roommate1[roommatesize],roommate1[i]);
	                strcpy(roommate2[roommatesize],roommate2[j]);
	                roommatesize++;
	            }
	        }	       
        }
    }
}

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    int i;
    roommate1 = malloc(1000 * sizeof(char*));
    for ( i = 0; i < 1000 ; i++)
    roommate1[i] = malloc((1000) * sizeof(char));

    roommate2 = malloc(1000 * sizeof(char*));
    for ( i = 0; i < 1000 ; i++)
    roommate2[i] = malloc((1000) * sizeof(char));

    friend1 = malloc(1000 * sizeof(char*));
    for ( i = 0; i < 1000 ; i++)
    friend1[i] = malloc((1000) * sizeof(char));

    friend2 = malloc(1000 * sizeof(char*));
    for ( i = 0; i < 1000 ; i++)
    friend2[i] = malloc((1000) * sizeof(char));

    classmate1 = malloc(1000 * sizeof(char*));
    for ( i = 0; i < 1000 ; i++)
    classmate1[i] = malloc((1000) * sizeof(char));

    classmate2 = malloc(1000 * sizeof(char*));
    for ( i = 0; i < 1000 ; i++)
    classmate2[i] = malloc((1000) * sizeof(char));


    yyparse();
    print_the_array();
  	checkroommates();
    checkclassmates();
    print_the_array();
    return 0;
}
