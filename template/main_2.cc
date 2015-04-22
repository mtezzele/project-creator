
/* Returns elapsed seconds past from the last call to timer rest */
double cclock()
{
	struct timeval tmp;
	double sec;
	gettimeofday( &tmp, (struct timezone *)0 );
	sec = tmp.tv_sec + ((double)tmp.tv_usec)/1000000.0;
	return sec;
}


int main(int argc, char *argv[])
{

	return 0;
}