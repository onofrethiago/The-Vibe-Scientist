* Clear memory
clear all

* Generate synthetic dataset (100 rows)
set obs 100
set seed 42
gen date = m(2018m1) + _n - 1
format date %tm
gen sales = int(runiform(100, 500) + (_n * 2))

* Calculate 3-month moving average
tssmooth ma ma3 = sales, window(2 1 0)

* Visualization
twoway (scatter sales date, mcolor("0 119 182%60") msize(medium)) ///
       (line ma3 date, lcolor("214 40 40") lwidth(thick)), ///
       title("{bf:Monthly Sales Analysis}", size(large) color(gs3)) ///
       xtitle("Date", size(medium)) ytitle("Sales Volume", size(medium)) ///
       plotregion(fcolor(white) lcolor(white)) ///
       graphregion(fcolor(white) lcolor(white)) ///
       legend(label(1 "Monthly Sales") label(2 "3-Month Moving Average") region(lcolor(white))) ///
       ylabel(, nogrid) xlabel(, nogrid)
