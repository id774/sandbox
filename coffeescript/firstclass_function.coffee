compose = (f, g) -> 
    (x) -> 
        f g x
 
fn  = [Math.sin,  Math.cos,  (x) -> Math.pow(x, 3)   ]
inv = [Math.asin, Math.acos, (x) -> Math.pow(x, 1/3) ]
 
do ->
	for i in [0..2]
        f = compose inv[i], fn[i]
        console.log f 0.5    # 0.5
