template foo(){
	struct ths{
		enum bar=3;
		enum get=8;
	}
	enum bar=3;
	enum foo=ths();
}
import std;

template numberedmonkyyytemplate(int i){
	struct numberedmonkyyytemplate_(S=int,S[] data=[]){
		alias T=typeof(data[0]);
	}
	alias numberedmonkyyytemplate=numberedmonkyyytemplate_;
}
void main(){
	foo!().bar.writeln;
	alias bar_=numberedmonkyyytemplate!0;
	bar_!float bar;
	bar_!().T baz;
	baz.writeln;
	alias faz_=numberedmonkyyytemplate!1;
	faz_!().T faz;
	faz.writeln;
}
