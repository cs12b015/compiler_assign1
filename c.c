#include <stdio.h>
#include <stdlib.h>
#include <string.h>



/*int contains(char** array1 , char** array2 ,int size,char* string1,char* string2){
    int returnflag=0;
    int i;
    for(i=0;i<size;i++){
        if(  (strcmp(array1[i],string1)==0 && (strcmp(array2[i],string2)==0)  || (strcmp(array1[i],string2)==0 && (strcmp(array2[i],string1)==0) ){
            returnflag=1;
        }
    }
    return returnflag;
}*/




void dofor(char* var1,char** data,int datasize,char* var,char* relation,char* name){
   	int i;
    if(strcmp(var1,var)==0){
        if(strcmp(relation,"friendof")==0){

            for(i = 0;i<datasize;i++){
            	friend1[friendsize]=data[i];
            	friend2[friendsize]=name;
            	friendsize++;
            }

        }else if (strcmp(relation,"classmateof")==0){
        	for(i = 0;i<datasize;i++){
            	classmate1[classmatesize]=data[i];
            	classmate2[classmatesize]=name;
            	classmatesize++;
            }
            
            
        }else if (strcmp(relation,"roommateof")==0){
            for(i = 0;i<datasize;i++){
            	roommate1[roommatesize]=data[i];
            	roommate2[roommatesize]=name;
            	roommatesize++;
            }

        }
    }else{
        errorbit=1;
    }
}










char** getdata(char* var,char* string2, char* name){
    char** data;
    int i;
    data = malloc(100 * sizeof(char*));
    for ( i = 0; i < 100 ; i++)
    data[i] = malloc((100) * sizeof(char));
    int index=0;

    if(strcmp(string2,"friendof")==0){
        for(i=0;i<friendsize;i++){
            if(strcmp(friend1[i],name)==0){
                strcpy(data[index],friend2[i]);
                index++;
            }
            if(strcmp(friend2[i],name)==0){
                strcpy(data[index],friend1[i]);
                index++;
            }
        }
    }else if(strcmp(string2,"classmateof")==0){
        for(i=0;i<classmatesize;i++){
            if(strcmp(classmate1[i],name)==0){
                strcpy(data[index],classmate2[i]);
                index++;
            }
            if(strcmp(classmate2[i],name)==0){
                strcpy(data[index],classmate1[i]);
                index++;
            }
        }
    }else if(strcmp(string2,"roommateof")==0){
        for(i=0;i<roommatesize;i++){
            if(strcmp(roommate1[i],name)==0){
                strcpy(data[index],roommate2[i]);
                index++;
            }
            if(strcmp(roommate2[i],name)==0){
                strcpy(data[index],roommate1[i]);
                index++;
            }
        }
    }
    return data;
}






char** splitarray(char* string){
    int i;
    char **array;
    array = malloc(100 * sizeof(char*));
    for ( i = 0; i < 100 ; i++)
    array[i] = malloc((100) * sizeof(char));

    char *p;

    i = 0;int j;
    p = strtok (string," ");  
    while (p != NULL)
    {
        array[i++]=p;
        
        p = strtok (NULL, " ");
    }
    for(j=0;j<i;j++){
        printf("%s\n",array[j]);
    }    
    return array;
}


/*

void printfinaloutput(){
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
                printf("%d: %s-----%s   ======>  %s------%s\n",classmatesize,classmate1[i],classmate2[i],classmate1[j],classmate2[j])
            }          
        }
    }
}

*/
int main(){
    char sep=' ';
    splitarray("name fo jayanth");
}