enum string abuse="(S=int,S[] data=[]){alias T=typeof(data[0]);static assert( ! is(T==int));}";
mixin template createmonkyyytemplate(string name){
	mixin("struct "~name~abuse);}