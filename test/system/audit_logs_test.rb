require "application_system_test_case"

class AuditLogsTest < ApplicationSystemTestCase
  setup do
    @audit_log = audit_logs(:one)
  end

  test "visiting the index" do
    visit audit_logs_url
    assert_selector "h1", text: "Audit logs"
  end

  test "should create audit log" do
    visit audit_logs_url
    click_on "New audit log"

    fill_in "Activity", with: @audit_log.activity
    fill_in "Ip address", with: @audit_log.ip_address
    fill_in "User", with: @audit_log.user_id
    click_on "Create Audit log"

    assert_text "Audit log was successfully created"
    click_on "Back"
  end

  test "should update Audit log" do
    visit audit_log_url(@audit_log)
    click_on "Edit this audit log", match: :first

    fill_in "Activity", with: @audit_log.activity
    fill_in "Ip address", with: @audit_log.ip_address
    fill_in "User", with: @audit_log.user_id
    click_on "Update Audit log"

    assert_text "Audit log was successfully updated"
    click_on "Back"
  end

  test "should destroy Audit log" do
    visit audit_log_url(@audit_log)
    click_on "Destroy this audit log", match: :first

    assert_text "Audit log was successfully destroyed"
  end
end
