template aliaslist(){
	struct mylist{
		struct readobject{
			enum has=false;
		}
		struct writeobject(alias A_){
			enum has=true;
			alias A=A_;
		}
		template numberedmonkyyytemplate(int i){
			//pragma(msg,i,"nmt");
			struct numberedmonkyyytemplate_(S=int,S[] data=[]){
				alias T=typeof(data[0]);
			}
			alias numberedmonkyyytemplate=numberedmonkyyytemplate_;
		}
		template access(int i){
			//pragma(msg,i,"acess");
			enum access=mixin("__LINE__");
		}
		template length_(int i,int sentinel){
			//pragma(msg,i," ",sentinel);
			static if(access!(i)>sentinel){
				enum length_=i;
			} else {
				enum length_=length_!(i+1,sentinel);
		}}
		template length(int i=__LINE__){
			//pragma(msg,"length");
			enum setty=mixin("__LINE__");
			alias length=length_!(0,setty);
		}
		template get_(int i,int j,list...){
			//pragma(msg,"get_",i);
			static if(i==j){
				//pragma(msg,"out",list);
				alias get_=list;
			} else {
				//pragma(msg,"has?");
				alias nmt=numberedmonkyyytemplate!(i);
				static if( nmt!().T.has){
					//pragma(msg,"has");
					alias get_=get_!(i+1,j,list,nmt!().T.A);
				} else {
					alias get_=get_!(i+1,j,list);
				}
			}
		}
		template get(int i=__LINE__){
			//pragma(msg,"get");
			enum l=length!i;
			alias nmt=numberedmonkyyytemplate!l;
			void foo(){nmt!(readobject) bar;}
			alias get=get_!(0,l);
		}
		template write(alias A,int i=__LINE__){
			//pragma(msg,"write");
			//pragma(msg,i,"init write");
			enum l=length!i;
			//pragma(msg,l,"length");
			alias nmt=numberedmonkyyytemplate!l;
			void foo(){nmt!(writeobject!A) bar;}
			alias write=get_!(0,l);
		}
	}
	alias aliaslist=mylist;
}

aliaslist!() mylist;
import std;
void main(){
	{
		alias a=mylist.write!bool;
		static foreach(e;mylist.get!()){
			e().writeln;
		}
	}
	"---".writeln;
	{
		alias b=mylist.write!int;
		static foreach(e;mylist.get!()){
			e().writeln;
			
		}
	}
	"---".writeln;
	{
		alias c=mylist.write!float;
		static foreach(e;mylist.get!()){
			e().writeln;
		}
	}
}