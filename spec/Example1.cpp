/**
 * - begin hinted parseable struct -
 */
struct Foo {
	// @hinted_parseable
	int oneWordType;

	char nonParseableField;

	// @hinted_parseable
	unsigned int twoWordsType;

	// @hinted_parseable
	__attribute__((aligned(64))) char fieldWithAttribute;

	/**
	 * This is a description.
	 *
	 * @hinted_parseable
	 */
	int multiLineComment;

	// This is a description.
	//
	// @hinted_parseable
	int multipleSingleLineComments;

	/**
	 * This is a description.
	 *
	 * @hinted_parseable
	 *
	 * More text.
	 */
	int moreCommentsAfterHint;

	// This is a description.
	//
	// @hinted_parseable
	//
	// More text.
	int moreSingleLineCommentsAfterHint;

	// @hinted_parseable
	int bitfield: 8;

	// @hinted_parseable
	void *pointer;

	// @hinted_parseable
	set<string> templateType;

	// @hinted_parseable
	char array[];

	// @hinted_parseable
	const int constField;

	// @hinted_parseable
	const int const constConstField;

	// @hinted_parseable
	const char * const * constConstCharArray[];
};
// - end hinted parseable struct -
