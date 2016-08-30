d.lrt$lrt <- 2 * (d.lrt$lnL.h1 - d.lrt$lnL.h0)
# this is for the branch-site test. df can be different for other tests.
d.lrt$pvalue <- pchisq(d.lrt$lrt, df=1, lower.tail = F)
d.lrt$qvalue <- qvalue(d.lr$pvalue, pi0.metho='bootstrap', robust=T)$qvalues
and then you just get significant by
subset(d.lrt, qvalue < 0.01)
