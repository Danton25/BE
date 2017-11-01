object Binary
{
	def binsearch(nos:Array[Int],srno:Int,l:Int,r:Int): Int=
	{
		var mid=(l+r)/2
		if(l>r)
		{
			return -1
		}
		else if(nos(mid)==srno)
		{
			return mid;
		}
		else if(nos(mid)>srno)
		{
			binsearch(nos,srno,l,mid-1)
		}
		else
		{
			binsearch(nos,srno,mid+1,r)
		}
	}	
	def main(args:Array[String])
	{
		println("ENTER THE NUMBER OF ELEMENTS")
		var n=Console.readInt
		var nos=new Array[Int](n)
		var r= scala.util.Random
		println("ENTER THE ELEMENTS")
		for(i<-0 to n-1)
		{
			nos(i)=r.nextInt(1000)
		}
		nos=nos.sorted
		for(i<-0 to n-1)
		{
			print(nos(i)+" ")
		}	
		println("\n ENTER SEARCH ELEMENT")
		var srno=Console.readInt
		var t1=System.nanoTime
		var pos:Int=binsearch(nos,srno,0,n-1)
		/*for(i<-0 to n-1)
		{
			print(nos(i)+"  ")
		}*/
		
		if(pos == -1)
		{
			println("NOT FOUND")
		}
		else
		{
			println("\nELEMENT FOUND AT POSITION "+(pos+1))
		}
		val duration= (System.nanoTime-t1)/1e9d
		println("TIME TAKEN: "+duration)
	}		 
}
