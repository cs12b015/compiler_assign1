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
    char **livevaribles;
    char **roommate1;
    char **roommate2;
    char **classmate1;
    char **classmate2;
    char **friend1;
    char **friend2;
    int datalength;

    char** getdata(char* var,char* string2, char* name);
    void addtoarray(char *a,char *b,char *c);
    void checkclassmates();
    void checkroommates();
    void printfinaloutput();
    char** split(char* str);
    void dofor(char* var1,char** data,int datasize,char* var,char* relation,char* name);
    int contains(char** array1 ,char** array2,int size,char* string1,char* string2);

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

%type <strng> instructions expression program ifexpression forexpression ifcondition instruction


%%

program       	:        instructions


instructions    :   instructions expression  
				|   instructions ifexpression
				|   instructions forexpression 
                |   {$$ = "";}
                ;

expression   	:   NAME RELATIONSHIP NAME {
                        addtoarray($1,$2,$3);  
                        checkroommates();
    					checkclassmates(); 

                    };
ifexpression  	:  IF ifcondition instruction ENDIF


forexpression  	:   FOREACH NAME RELATIONSHIP VARIABLE instruction ENDFOREACH {errorbit=1;}
				|	FOREACH VARIABLE RELATIONSHIP NAME instruction ENDFOREACH {
						char** array=split($5);
						char** data =getdata($2,$3,$4);
						int datasize = datalength;
						dofor($2,data,datasize,array[0],array[1],array[2]);
					}


ifcondition		: 	NAME RELATIONSHIP NAME
				|	NAME RELATIONSHIP VARIABLE
				|	VARIABLE RELATIONSHIP NAME
				;

instruction 	:	VARIABLE RELATIONSHIP NAME{
						int len=4; len+=strlen($1); len+=strlen($2); len+=strlen($3);
						char* stringg;
						stringg=(char*)malloc((sizeof (char)* len)+1);
						sprintf(stringg,"%s %s %s",$1,$2,$3); 
						$$ = strdup(stringg);
					}
				;



%%


char** getdata(char* var,char* string2, char* name){
    char** data;
    int i;
    data = malloc(100 * sizeof(char*));
    for ( i = 0; i < 100 ; i++)
    data[i] = malloc((100) * sizeof(char));
    datalength=0;

    if(strcmp(string2,"friendof")==0){
        for(i=0;i<friendsize;i++){
            if(strcmp(friend1[i],name)==0){
                strcpy(data[datalength],friend2[i]);
                datalength++;
            }
            if(strcmp(friend2[i],name)==0){
                strcpy(data[datalength],friend1[i]);
                datalength++;
            }
        }
    }else if(strcmp(string2,"classmateof")==0){
        for(i=0;i<classmatesize;i++){
            if(strcmp(classmate1[i],name)==0){
                strcpy(data[datalength],classmate2[i]);
                datalength++;
            }
            if(strcmp(classmate2[i],name)==0){
                strcpy(data[datalength],classmate1[i]);
                datalength++;
            }
        }
    }else if(strcmp(string2,"roommateof")==0){
        for(i=0;i<roommatesize;i++){
        	//printf("%s-------%d-----%s\n",roommate1[i],roommatesize,name);
            if(strcmp(roommate1[i],name)==0){

                strcpy(data[datalength],roommate2[i]);
                datalength++;
            }

           // printf("%s------%d------%s\n",roommate2[i],roommatesize,name);
            if(strcmp(roommate2[i],name)==0){
                strcpy(data[datalength],roommate1[i]);
                datalength++;
            }
        }
    }
    return data;
}


void dofor(char* var1,char** data,int datasize,char* var,char* relation,char* name){
   	int i;
    if(strcmp(var1,var)==0){
        if(strcmp(relation,"friendof")==0){
        		//printf("I am Printing Data\n");

            for(i = 0;i<datasize;i++){
            	//printf("%s\n",data[i]);
            	friend1[friendsize]=data[i];
            	friend2[friendsize]=name;
            	friendsize++;
            }
            	//printf("Done Printing Data\n");
        }else if (strcmp(relation,"classmateof")==0){
        	for(i = 0;i<datasize;i++){
            	classmate1[classmatesize]=data[i];
            	classmate2[classmatesize]=name;
            	classmatesize++;
            }
   			checkclassmates();            
        }else if (strcmp(relation,"roommateof")==0){
            for(i = 0;i<datasize;i++){
            	roommate1[roommatesize]=data[i];
            	roommate2[roommatesize]=name;
            	roommatesize++;
            }
            checkroommates();
        }
    }else{
        errorbit=1;
    }
}



char** split(char* str){
  int i;
  char** array;
  array = malloc(100 * sizeof(char*));
  for ( i = 0; i < 100 ; i++)
    array[i] = malloc((100) * sizeof(char));

  int size=0;
  char * pch;
  pch = strtok (strdup(str)," ");
  while (pch != NULL)
  {
    strcpy(array[size++], pch);
    pch = strtok (NULL, " ");
  }
  return array;
}





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


int contains(char** array1 , char** array2 ,int size,char* string1,char* string2){
    int returnflag=0;
    int i;
    for(i=0;i<size;i++){
        if(  (strcmp(array1[i],string1)==0 && (strcmp(array2[i],string2)==0))  || (strcmp(array1[i],string2)==0 && (strcmp(array2[i],string1)==0)) ){
            returnflag=1;
        }
    }
    return returnflag;
}



void printfinaloutput(){
	int i;
	if(errorbit==0){
	    printf("graph\n{\n");
	    for( i=0;i<friendsize;i++){
	        printf("%s -- %s [label=\"friendof\"]\n",friend1[i],friend2[i]);
	    }
	    printf("\n");
	    for( i=0;i<roommatesize;i++){
	        printf("%s -- %s [label=\"roommateof\"]\n",roommate1[i],roommate2[i]);
	    }
	     printf("\n");
	    for( i=0;i<classmatesize;i++){
	        printf("%s -- %s [label=\"classmateof\"]\n",classmate1[i],classmate2[i]);
	    }
	    printf("}\n");
    }
    else{
    	printf("ERROR\n");
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
    for(i=0;i<classmatesize;i++){
        for(j=i;j<classmatesize;j++){
            if(i==j){}
            else{
                if(strcmp(classmate1[i],classmate1[j])==0){
                    if(contains(classmate1,classmate2,classmatesize,classmate2[i],classmate2[j])==0 ){
                        strcpy(classmate1[classmatesize],classmate2[i]);
                        strcpy(classmate2[classmatesize],classmate2[j]);
                        classmatesize++;
                    }
                }else if(strcmp(classmate1[i],classmate2[j])==0){
                    if(contains(classmate1,classmate2,classmatesize,classmate2[i],classmate1[j])==0 ){
                           strcpy(classmate1[classmatesize],classmate2[i]);
                           strcpy(classmate2[classmatesize],classmate1[j]);
                           classmatesize++;
                    }                
                }else if(strcmp(classmate2[i],classmate2[j])==0){
                    if(contains(classmate1,classmate2,classmatesize,classmate1[i],classmate1[j])==0 ){
                        strcpy(classmate1[classmatesize],classmate1[i]);
                        strcpy(classmate2[classmatesize],classmate1[j]);
                        classmatesize++;
                    }
                }else if(strcmp(classmate2[i],classmate1[j])==0){
                    if(contains(classmate1,classmate2,classmatesize,classmate1[i],classmate2[j])==0 ){
                        strcpy(classmate1[classmatesize],classmate1[i]);
                        strcpy(classmate2[classmatesize],classmate2[j]);
                        classmatesize++;
                    }
                }
                //printf("%d: %s-----%s   ======>  %s------%s\n",classmatesize,classmate1[i],classmate2[i],classmate1[j],classmate2[j]);
            }          
        }
    }
}


void checkroommates(){
    int i,j;
    int temproommatesize=roommatesize;
    for(i=0;i<roommatesize;i++){
        for(j=i;j<roommatesize;j++){
	        if(i==j){}
	        else{
	            if(strcmp(roommate1[i],roommate1[j])==0){
	            	if(contains(roommate1,roommate2,roommatesize,roommate2[i],roommate2[j])==0 ){
		                strcpy(roommate1[roommatesize],roommate2[i]);
		                strcpy(roommate2[roommatesize],roommate2[j]);
		                roommatesize++;
		            }
	            }else if(strcmp(roommate1[i],roommate2[j])==0){
	            	if(contains(roommate1,roommate2,roommatesize,roommate2[i],roommate1[j])==0 ){
		                strcpy(roommate1[roommatesize],roommate2[i]);
		                strcpy(roommate2[roommatesize],roommate1[j]);
		                roommatesize++;  
		            }              
	            }else if(strcmp(roommate2[i],roommate2[j])==0){
	            	if(contains(roommate1,roommate2,roommatesize,roommate1[i],roommate1[j])==0 ){
		                strcpy(roommate1[roommatesize],roommate1[i]);
		                strcpy(roommate2[roommatesize],roommate1[j]);
		                roommatesize++;
		            }
	            }else if(strcmp(roommate2[i],roommate1[j])==0){
	            	if(contains(roommate1,roommate2,roommatesize,roommate1[i],roommate2[j])==0 ){
		                strcpy(roommate1[roommatesize],roommate1[i]);
		                strcpy(roommate2[roommatesize],roommate2[j]);
		                roommatesize++;
		            }
	            }
	        	//printf("%d: \n",roommatesize);
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
  	checkroommates();
    checkclassmates();
   //print_the_array();
    printfinaloutput();
    return 0;
}
