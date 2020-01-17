%%
begin|end|start		;
[0-9][0-9]*[.][0-9]+	printf("zm\n");
[0-9]+			printf("cał\n");
[0-9][A-Za-z0-9_]*	printf("naz\n");
.			printf("Bład\n");
