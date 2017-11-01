%{
#include<stdio.h>
#include<string.h>
#include<stdlib.h>

char AddToTable(char, char, char);
void ThreeAddressCode();
void Quadraple();
void Triple();
int search(char);

int index1=0;
char temp='A';

struct expr{
	char operand1;
	char operand2;
	char operator;
	char result;
};
%}


%union
{
char symbol;
}

%token <symbol> LETTER NUMBER
%type <symbol> exp						//error: %token

%left '-''+'
%left '*''/'

%%

statement: LETTER '=' exp ';' {AddToTable((char)$1,(char)$3,'=');}		//error: letter = number ; 	
			| exp ';'
			;
exp: exp '+' exp {$$=AddToTable((char)$1,(char)$3,'+');}
	|exp '-' exp {$$=AddToTable((char)$1,(char)$3,'-');}
	|exp '*' exp {$$=AddToTable((char)$1,(char)$3,'*');}
	|exp '/' exp {$$=AddToTable((char)$1,(char)$3,'/');}
	|'(' exp ')' {$$=(char)$2;}
	| NUMBER {$$ = (char)$1;}
    | LETTER {$$ = (char)$1;}
    ;
%%

yyerror(char *s)
{
	printf("%s",s);
	exit(0);
}

struct expr arr[20];					//forgot

char AddToTable(char operand1,char operand2, char operator)
{	
	temp++;
	arr[index1].operand1=operand1;
    arr[index1].operand2=operand2;
    arr[index1].operator=operator;
    arr[index1].result=temp;
    index1++;
    return temp;
}

void ThreeAddressCode()
{
	char temp='A';
	int cnt=0;
	temp++;
	while(cnt<index1)
	{
		printf("%c := \t", temp);
		
		if(isalpha(arr[cnt].operand1))
			printf("%c \t", arr[cnt].operand1);
		else
			printf("%c \t", temp);
		
		printf("%c \t", arr[cnt].operator);
		
		if(isalpha(arr[cnt].operand2))
			printf("%c \t", arr[cnt].operand2);
		else
			printf("%c \t", temp);
			
		temp++;
		cnt++;
		printf("\n");
	}
}

void Quadraple()
{
	char temp='A';
	int cnt=0;
	temp++;
	while(cnt<index1)
	{	
		printf("%c \t", arr[cnt].operator);
		
		if(isalpha(arr[cnt].operand1))
			printf("%c \t", arr[cnt].operand1);
		else
			printf("%c \t", temp);
		
		if(isalpha(arr[cnt].operand2))
			printf("%c \t", arr[cnt].operand2);
		else
			printf("%c \t", temp);
		
		printf("%c  \t", temp);
			
		temp++;
		cnt++;
		printf("\n");
	}
}

void Triple()
{
	int cnt=0;
	char temp='A';
	int flag;
	temp++;
	
	while(cnt<index1)
	{
		if(isalpha(arr[cnt].operand1) && isupper(arr[cnt].operand1))
		{
			flag=search(arr[cnt].operand1);
			printf("%d \t",flag);
		}
		else if(isalpha(arr[cnt].operand1))
			printf("%c \t", arr[cnt].operand1);
		else
			printf("%c \t", temp);
			
		if(isalpha(arr[cnt].operand2) && isupper(arr[cnt].operand2))
		{
			flag=search(arr[cnt].operand2);
			printf("%d \t",flag);
		}
		else if(isalpha(arr[cnt].operand2))
			printf("%c \t", arr[cnt].operand2);
		else
			printf("%c \t", temp);
		
		printf("%c \t", arr[cnt].operator);
		temp++;
		cnt++;
		printf("\n");

	}

}

int search(char find)
{
int i;
	for(i=0;i<index1;i++)
	{
		if(arr[i].result==find)
		return i;
	}
	return 0;

}

int main()
{
	printf("Enter the expression: ");
	temp='A';
	yyparse();
	printf("\n");
	ThreeAddressCode();
	printf("\n");
	Quadraple();
	printf("\n");
	Triple();
	return 0;
}

int yywrap()
{
	return 1;
}



/*
morgan@morgan-HP-Pavilion-Notebook:~/CL1/prac1$ lex a5.l
morgan@morgan-HP-Pavilion-Notebook:~/CL1/prac1$ yacc -d a5.y
morgan@morgan-HP-Pavilion-Notebook:~/CL1/prac1$ gcc lex.yy.c y.tab.c -w
morgan@morgan-HP-Pavilion-Notebook:~/CL1/prac1$ ./a.out 
Enter the expression: k=l+m-n/a;

B := 	l 	+ 	m 	
C := 	n 	/ 	a 	
D := 	B 	- 	C 	
E := 	k 	= 	D 	

+ 	l 	m 	B  	
/ 	n 	a 	C  	
- 	B 	C 	D  	
= 	k 	D 	E  	

l 	m 	+ 	
n 	a 	/ 	
0 	1 	- 	
k 	2 	= 	
morgan@morgan-HP-Pavilion-Notebook:~/CL1/prac1$ 

*/
















