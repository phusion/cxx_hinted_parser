/**
 * - begin hinted parseable struct -
 */
struct Foo {
	// @prefix not-parsed
	// @hinted_parseable
	// @author Joe
	// @date today
	// @flag1
	int simple;


	// @prefix not-parsed
	//
	// blabla
	//
	// @hinted_parseable
	//
	// blabla
	//
	// @author Jane
	//
	// blabla
	//
	// @date tomorrow
	//
	// blabla
	//
	// @flag2
	int complex;
};
// - end hinted parseable struct -
