module DatasetHelper

  include Mocks::Ezid

  def start_new_dataset
    mock_minting!
    click_button 'Start New Dataset'
    expect(page).to have_content('Describe Dataset')
    navigate_to_metadata
  end

  def navigate_to_metadata
    # Make sure you switch to the Selenium driver for the test calling this helper method
    # e.g. `it 'should test this amazing thing', js: true do`
    click_link 'Describe Dataset'
    expect(page).to have_content('Dataset: Basic Information', wait: 10)
  end

  def navigate_to_upload
    # Make sure you switch to the Selenium driver for the test calling this helper method
    # e.g. `it 'should test this amazing thing', js: true do`
    click_link 'Upload Files'
    expect(page).to have_content('Step 2: Choose Files', wait: 10)
  end

  def navigate_to_review
    # Make sure you switch to the Selenium driver for the test calling this helper method
    # e.g. `it 'should test this amazing thing', js: true do`
    click_link 'Review and Submit'
    expect(page).to have_content('Review Description', wait: 10)
  end

  def fill_required_fields
    # make sure we're on the right page
    navigate_to_metadata

    # ##############################
    # Title
    fill_in 'title', with: Faker::Lorem.sentence

    # ##############################
    # Author
    fill_in_author

    # TODO: additional author(s)

    # ##############################
    # Abstract
    abstract = find_blank_ckeditor_id('description_abstract')
    fill_in_ckeditor abstract, with: Faker::Lorem.paragraph

    # ##############################
    # LICENSE/PAYMENT AGREEMENTS
    agree_to_everything
  end

  def fill_article_info(name:, msid:)
    choose('choose_manuscript')
    fill_in 'internal_datum[publication_name]', with: name
    fill_in 'internal_datum[msid]', with: msid
  end

  def fill_in_author
    fill_in 'author[author_first_name]', with: Faker::Name.unique.first_name
    fill_in 'author[author_last_name]', with: Faker::Name.unique.last_name
    # TODO: make consistent with other author fields
    fill_in 'affiliation', with: Faker::Educator.university
    fill_in 'author[author_email]', with: Faker::Internet.safe_email
  end

  def agree_to_everything
    navigate_to_review
    find('#agree_to_license').click
    find('#agree_to_payment').click
  end

end
