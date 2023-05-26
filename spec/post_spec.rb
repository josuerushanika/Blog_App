require 'rails_helper'

RSpec.describe Post, type: :model do
  subject do
    Post.new(title: 'some title', text: 'some text', comments_counter: 0, likes_counter: 0, created_at: nil,
             updated_at: nil)
  end

  before { subject.save }

  it 'should have a title present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'should have a title with a maximum length of 250 characters' do
    subject.title = 'A' * 251
    expect(subject).to_not be_valid
  end

  it 'should have a non-negative comments counter' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'should have a non-negative likes counter' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end
end
