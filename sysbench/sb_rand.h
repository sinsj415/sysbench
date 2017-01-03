/*
   Copyright (C) 2016-2017 Alexey Kopytov <akopytov@gmail.com>

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
*/

#ifndef SB_RAND_H
#define SB_RAND_H

#include <stdlib.h>

/* Random numbers distributions */
typedef enum
{
  DIST_TYPE_UNIFORM,
  DIST_TYPE_GAUSSIAN,
  DIST_TYPE_SPECIAL,
  DIST_TYPE_PARETO
} rand_dist_t;

/* Pick the best available re-entrant PRNG */
#if defined(HAVE_LRAND48_R)
extern TLS struct drand48_data sb_rng_state;

static inline long sb_rnd(void)
{
  long result;

  lrand48_r(&sb_rng_state, &result);

  return result;
}
static inline double sb_rnd_double(void)
{
  double result;

  drand48_r(&sb_rng_state, &result);

  return result;
}
#define sb_srnd(seed) srand48_r(seed, &sb_rng_state)

#elif defined(HAVE_RAND_R)
extern TLS unsigned int sb_rng_state;
# define sb_rnd() (rand_r(&sb_rng_state))
# define sb_srnd(seed) do { sb_rng_state = seed; } while(0)
/* On some platforms rand() may return values larger than RAND_MAX */
# define sb_rnd_double() ((double) (sb_rnd() % RAND_MAX) / RAND_MAX)
#elif defined(_WIN32)
extern __declspec(thread) unsigned int sb_rng_state;
# define sb_rnd() (rand_s(&sb_rng_state))
# define sb_srnd(seed) do { sb_rng_state = seed; } while(0)
/* On some platforms rand() may return values larger than RAND_MAX */
# define sb_rnd_double() ((double) (sb_rnd() % RAND_MAX) / RAND_MAX)
#else
# error No re-entrant PRNG function found.
#endif

extern int sb_rand_seed; /* optional seed set on the command line */

int sb_rand_register(void);
void sb_rand_print_help(void);

int sb_rand_init(void);
void sb_rand_done(void);

int sb_rand_default(int, int);
int sb_rand_uniform(int, int);
int sb_rand_gaussian(int, int);
int sb_rand_special(int, int);
int sb_rand_pareto(int, int);
int sb_rand_uniq(int a, int b);
void sb_rand_str(const char *, char *);

#endif /* SB_RAND_H */
