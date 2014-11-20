require 'spec_helper'

describe BetterDatePicker::Model do
  class Widget
    include ActiveModel::Model
    include ActiveModel::Validations::Callbacks
    include BetterDatePicker::Model


    attr_accessor :built_at

    validates :built_at,
      presence: true

    better_date_picker :built_at
  end

  it 'allows the setting of a date via a string' do
    widget = Widget.new
    date_string = '03/09/1984'
    widget.built_at_date = date_string
    expect(widget.built_at).to eql(Chronic.parse(date_string))
  end

  it 'sets the date to nil when assigned' do
    widget = Widget.new
    widget.built_at = Date.today
    widget.built_at_date = nil
    expect(widget.built_at).to be_nil
  end

  it 'sets the date to nil when a badly formed string is assigned' do
    widget = Widget.new
    widget.built_at = Date.today
    widget.built_at_date = "INVALID DATE"
    expect(widget.built_at).to be_nil
  end

  it 'sets the date string when the date is set' do
    widget = Widget.new
    widget.built_at = Date.today
    expect(widget.built_at_date).to be_kind_of(String)
  end

  it 'nils the date string when the date is assigned nil' do
    widget = Widget.new
    widget.built_at_date = 'yesterday'
    widget.built_at = nil
    expect(widget.built_at_date).to be_nil
  end

  it 'propagates errors to the stringified version when validated' do
    widget = Widget.new
    expect(widget).to_not be_valid
    expect(widget.errors[:built_at_date]).to_not be_blank
  end
end
