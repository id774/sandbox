for(i in 1:10){
 plot(function(x)(1/2)*i*exp(1)^(-i*abs(x)),from=-5,to=5,col=i,ylim=c(0,0.5))
 par(new=T)
}
