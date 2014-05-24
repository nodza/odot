require File.expand_path('spec/spec_helper')

describe "Creating todo lists" do
  it "redirects to the todo list index page upon success" do
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New todo_list")

    fill_in "Title", with: "This is how we do it"
    fill_in "Description", with: "My list of todos"
    click_button "Create Todo list"

    expect(page).to have_content("This is how we do it")
  end

  it "displays an error when the todo list has no title" do
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New todo_list")

    fill_in "Title", with: ""
    fill_in "Description", with: "My list of todos"
    click_button "Create Todo list"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("This is how we do it")
  end

  it "displays an error when the todo list has a title of less than 3 characters" do
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New todo_list")

    fill_in "Title", with: "Hi"
    fill_in "Description", with: "My list of todos"
    click_button "Create Todo list"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("This is how we do it")
  end

end