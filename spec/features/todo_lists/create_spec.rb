require File.expand_path('spec/spec_helper')

describe "Creating todo lists" do

  def create_todo_list(options={})
    options[:title] ||= "This is how we do it"
    options[:description] ||= "My list of todos"

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New todo_list")

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Create Todo list"
  end

  it "redirects to the todo list index page upon success" do
    create_todo_list
    expect(page).to have_content("This is how we do it")
  end

  it "displays an error when the todo list has no title" do
    expect(TodoList.count).to eq(0)

    create_todo_list title: ""

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("This is how we do it")
  end

  it "displays an error when the todo list has a title of less than 3 characters" do
    expect(TodoList.count).to eq(0)

    create_todo_list title: "Hi"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("This is how we do it")
  end

  it "displays an error when the todo list has no description" do
    expect(TodoList.count).to eq(0)

    create_todo_list title: "My List of Errands", description: ""

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("My list of errands")
  end

  it "displays an error when the todo list has a description of less than 5 characters" do
    expect(TodoList.count).to eq(0)

    create_todo_list title: "My List of Errands", description: "Idk"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("My list of errands")
  end

end