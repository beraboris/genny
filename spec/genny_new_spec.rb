require 'support/cli'
require 'support/template'

describe 'genny new' do
  include FakeFS::SpecHelpers

  it 'should copy files over' do
    make_template 'foobar',
                  'some-file.conf': 'something',
                  'dir/stuff.conf': 'something else'

    root = Pathname.new '/dest/stuff'
    run_genny 'new', 'foobar', root

    expect(root).to exist
    expect(root + 'some-file.conf').to exist
    expect((root + 'some-file.conf').read).to eq 'something'
    expect(root + 'dir').to exist
    expect(root + 'dir').to be_directory
    expect(root + 'dir/stuff.conf').to exist
    expect((root + 'dir/stuff.conf').read).to eq 'something else'
  end

  it 'should complain when files are missing'
end
