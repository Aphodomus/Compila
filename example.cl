Class List inherits IO { 
	isNil() : Bool { { abort(); true; } };

	cons(hd : Int) : Cons {
	  (let new_cell : Cons <- new Cons in
		new_cell.init(hd,self)
	  )
	};

	(*   *)
	car() : Int { { abort(); new Int; } };

	cdr() : List { { abort(); new List; } };

	rev() : List { cdr() };

	sort() : List { cdr() };

	insert(i : Int) : List { cdr() };

	rcons(i : Int) : List { cdr() };
	
	print_list() : Object { abort() };
};

Class Cons inherits List {
	xcar : Int;  
	xcdr : List; 

	isNil() : Bool { false };

	init(hd : Int, tl : List) : Cons {
	  {
	    xcar <- hd;
	    xcdr <- tl;
	    self;
	  }
	};
	  
	car() : Int { xcar };

	cdr() : List { xcdr };

	rev() : List { (xcdr.rev()).rcons(xcar) };

	sort() : List { (xcdr.sort()).insert(xcar) };

	insert(i : Int) : List {
		if i < xcar then  --if else
			(new Cons).init(i,self)
		else
			(new Cons).init(xcar,xcdr.insert(i))
		fi
	};


	rcons(i : Int) : List { (new Cons).init(xcar, xcdr.rcons(i)) };

	print_list() : Object {
		{
		     out_int(xcar);
		     out_string("\n");
		     xcdr.print_list();
		}
	};
};

--declaração de classes
Class Nil inherits List { 
	isNil() : Bool { true };  --declaração de métodos

        rev() : List { self };

	sort() : List { self };

	insert(i : Int) : List { rcons(i) };

	rcons(i : Int) : List { (new Cons).init(i,self) };

	print_list() : Object { true };

};

(*Métodos para lista*)
Class Main inherits IO {

	l : List; --atribuição
	

	iota(i : Int) : List {  
	    {
	   
		l <- new Nil;
		(let j : Int <- 0 in
		   while j < i  --teste da estrutura while
		   loop 
		     {
		       l <- (new Cons).init(j,l);
		       j <- j + 1;
		     } 
		   pool
		);
		l;
	    }
	};		

	main() : Object {
	   {
	     out_string("How many numbers to sort? "); --teste da estrutura para mostrar a mensagem na tela
	     iota(in_int()).rev().sort().print_list(); --teste da estrutura de métodos
	   }
	};
};


