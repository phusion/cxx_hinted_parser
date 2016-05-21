#  Copyright (c) 2016 Phusion Holding B.V.
#
#  "Union Station" and "Passenger" are trademarks of Phusion Holding B.V.
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in
#  all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#  THE SOFTWARE.

require_relative '../lib/cxx_hinted_parser/parser'

SPEC_DIR = File.absolute_path(File.dirname(__FILE__))

module CxxHintedParser

describe Parser do
  it 'works' do
    parser = Parser.load_file("#{SPEC_DIR}/Example1.cpp").parse
    expect(parser.structs.keys).to contain_exactly('Foo')
    expect(parser.errors.size).to eq(0)

    foo = parser.structs['Foo']
    expect(foo.size).to eq(14)
    i = 0

    expect(foo[i].type).to eq('int')
    expect(foo[i].name).to eq('oneWordType')
    expect(foo[i].metadata).to eq({})
    i += 1

    expect(foo[i].type).to eq('unsigned int')
    expect(foo[i].name).to eq('twoWordsType')
    expect(foo[i].metadata).to eq({})
    i += 1

    expect(foo[i].type).to eq('char')
    expect(foo[i].name).to eq('fieldWithAttribute')
    expect(foo[i].metadata).to eq({})
    i += 1

    expect(foo[i].type).to eq('int')
    expect(foo[i].name).to eq('multiLineComment')
    expect(foo[i].metadata).to eq({})
    i += 1

    expect(foo[i].type).to eq('int')
    expect(foo[i].name).to eq('multipleSingleLineComments')
    expect(foo[i].metadata).to eq({})
    i += 1

    expect(foo[i].type).to eq('int')
    expect(foo[i].name).to eq('moreCommentsAfterHint')
    expect(foo[i].metadata).to eq({})
    i += 1

    expect(foo[i].type).to eq('int')
    expect(foo[i].name).to eq('moreSingleLineCommentsAfterHint')
    expect(foo[i].metadata).to eq({})
    i += 1

    expect(foo[i].type).to eq('int')
    expect(foo[i].name).to eq('bitfield')
    expect(foo[i].metadata).to eq({})
    i += 1

    expect(foo[i].type).to eq('void *')
    expect(foo[i].name).to eq('pointer')
    expect(foo[i].metadata).to eq({})
    i += 1

    expect(foo[i].type).to eq('set<string>')
    expect(foo[i].name).to eq('templateType')
    expect(foo[i].metadata).to eq({})
    i += 1

    expect(foo[i].type).to eq('char []')
    expect(foo[i].name).to eq('array')
    expect(foo[i].metadata).to eq({})
    i += 1

    expect(foo[i].type).to eq('const int')
    expect(foo[i].name).to eq('constField')
    expect(foo[i].metadata).to eq({})
    i += 1

    expect(foo[i].type).to eq('const int const')
    expect(foo[i].name).to eq('constConstField')
    expect(foo[i].metadata).to eq({})
    i += 1

    expect(foo[i].type).to eq('const char * const * []')
    expect(foo[i].name).to eq('constConstCharArray')
    expect(foo[i].metadata).to eq({})
    i += 1
  end

  it 'reports errors' do
    parser = Parser.load_file("#{SPEC_DIR}/ExampleWithErrors.cpp").parse
    expect(parser.structs.keys).to contain_exactly('Foo')

    errors = parser.errors
    expect(parser.errors.size).to eq(2)
    i = 0

    expect(errors[i].message).to eq('Unable to parse field name and type')
    i += 1

    expect(errors[i].message).to match(/no corresponding class\/struct begin hint/)
    i += 1
  end

  it 'extracts metadata' do
    parser = Parser.load_file("#{SPEC_DIR}/ExampleWithMetadata.cpp").parse
    expect(parser.structs.keys).to contain_exactly('Foo')
    expect(parser.errors.size).to eq(0)

    foo = parser.structs['Foo']
    expect(foo.size).to eq(2)
    i = 0

    expect(foo[i].type).to eq('int')
    expect(foo[i].name).to eq('simple')
    expect(foo[i].metadata).to eq(author: 'Joe', date: 'today', flag1: true)
    i += 1

    expect(foo[i].type).to eq('int')
    expect(foo[i].name).to eq('complex')
    expect(foo[i].metadata).to eq(author: 'Jane', date: 'tomorrow', flag2: true)
    i += 1
  end
end

end
