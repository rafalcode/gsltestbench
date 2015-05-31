/*  this is an example from the permutations chapter in 
 *  the GSL reference amanual */
#include   <stdio.h>
#include   <gsl/gsl_rng.h>
#include   <gsl/gsl_randist.h>
#include   <gsl/gsl_permutation.h>

int main (void)
{
    const size_t N = 5;
    unsigned int i;
    const gsl_rng_type *T;
    gsl_rng *r;

    gsl_permutation *p = gsl_permutation_alloc(N);
    gsl_permutation *q = gsl_permutation_alloc(N);

    gsl_rng_env_setup();
    T = gsl_rng_default;
    r = gsl_rng_alloc (T);

    printf ("initial permutation:");
    gsl_permutation_init(p);
    gsl_permutation_fprintf(stdout, p, " %u");
    printf ("\n");

    printf ("random permutation:");
    gsl_ran_shuffle (r, p->data, N, sizeof(size_t));
    gsl_permutation_fprintf (stdout, p, " %u");
    printf ("\n");

    printf ("cyclical form of above (brackets excluded unfortunately):");
    gsl_permutation_linear_to_canonical(q, p);
    gsl_permutation_fprintf (stdout, q, " %u");
    printf ("\n");

    printf ("inverse permutation:");
    gsl_permutation_inverse (q, p);
    gsl_permutation_fprintf (stdout, q, " %u");
    printf ("\n");

    /*  Note in the following printf, we acceed to actual members of the gsl_permutation struct */
    printf ("Verify that p[q[i]]=i in order to check inverse:");
    for(i=0;i<N;i++)
        printf(" %zu",p->data[q->data[i]]); 
    printf ("\n");

    gsl_permutation_free (p);
    gsl_permutation_free (q);
    gsl_rng_free (r);

    return 0;
}
// Here is the output from the program,
//        $ ./a.out
//        initial permutation: 0 1 2 3 4 5 6 7 8 9
//          random permutation: 1 3 5 2 7 6 0 4 9 8
//        inverse permutation: 6 0 3 1 7 2 5 4 9 8
// The random permutation p[i] and its inverse q[i] are related through the identity p[q[i]]
// = i, which can be veriﬁed from the output.
