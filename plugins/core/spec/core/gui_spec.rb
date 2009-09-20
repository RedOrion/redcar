require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe Redcar::Gui do
  before do
    Redcar::Gui.all.clear
    @gui = Redcar::Gui.new("test gui")
  end
  
  it "has a name" do
    @gui.name.should == "test gui"
  end
  
  it "registers itself" do
    Redcar::Gui.all.map(&:name).should == ["test gui"]
  end
  
  it "delegates start and stop to the event loop" do
    event_loop = mock("Event Loop")
    event_loop.should_receive(:start)
    event_loop.should_receive(:stop)
    
    @gui.register_event_loop(event_loop)
    
    @gui.start
    @gui.stop
  end
  
  it "manages controller classes" do
    @gui.register_controller(String => Date)
    @gui.controller_for("").should == Date
  end
end