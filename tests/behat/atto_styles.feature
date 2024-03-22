@editor @editor_atto @atto @atto_styles
Feature: Atto styles
  To add and use block and inline styles with one and two classes each

  Background:
    Given I log in as "admin"
    And the config value "config" of "atto_styles" is set as admin to multiline
      """
      [{
          "title": "Hero unit box",
          "type": "block",
          "classes": "hero-unit"
      },{
          "title": "Muted Well",
          "type": "block",
          "classes": "well text-muted"
      },{
          "title": "Float Left",
          "type": "inline",
          "classes": "pull-left"
      },{
          "title": "Warning text",
          "type": "inline",
          "classes": "label label-warning"
      },{
        "title": "Heading 3",
        "type": "h3",
        "classes": ""
      }]
      """
    And the config value "toolbar" of "editor_atto" is set as admin to multiline
      """
      collapse = collapse
      style1 = title, styles, bold, italic
      list = unorderedlist, orderedlist
      links = link
      files = image, media, managefiles
      style2 = underline, strike, subscript, superscript
      align = align
      indent = indent
      insert = equation, charmap, table, clear
      undo = undo
      accessibility = accessibilitychecker, accessibilityhelper
      other = html
      """
    And I log out

  @javascript
  Scenario: Test JSON validation of the setting
    Given I log in as "admin"
    And I navigate to "Plugins > Text editors > Atto HTML editor > Styles settings " in site administration
    And I set the field "Styles configuration" to multiline:
    """
    Just a non JSON string.
    """
    And I press "Save changes"
    Then I should see "Some settings were not changed due to an error."
    And I should see "Entered JSON code is not valid."
    When I set the field "Styles configuration" to multiline:
    """
     {
          "title": "Hero unit box",
          "type": "block",
          "classes": "hero-unit"
      }
    """
    And I press "Save changes"
    Then I should not see "Some settings were not changed due to an error."
    And I should not see "Entered JSON code is not valid."
    When I set the field "Styles configuration" to multiline:
    """
     [{
          "title": "Hero unit box",
          "type": "block"
          "classes": "hero-unit"
      }]
    """
    And I press "Save changes"
    Then I should see "Some settings were not changed due to an error."
    And I should see "Entered JSON code is not valid."
    When I set the field "Styles configuration" to multiline:
     """
     [{
          "title": "Hero unit box",
          "type": "block",
          "classes": "hero-unit"
      }]
    """
    And I press "Save changes"
    Then I should not see "Some settings were not changed due to an error."
    And I should not see "Entered JSON code is not valid."

  @javascript
  Scenario Outline: Test inline styles with one and two classes
    Given I log in as "admin"
    And I open my profile in edit mode
    And I set the field "Description" to <text>
    And I select the text in the "Description" Atto editor
    And I click on "Show more buttons" "button"
    When I click on "Styles" "button"
    And I click on <style> "link"
    And I click on "HTML" "button"
    Then the field "Description" matches value <html>

    Examples:
      | text            | style           | html                                                 |
      | "float"         | "Float Left"    | "<span class=\"pull-left\">float</span>"             |
      | "warning"       | "Warning text"  | "<span class=\"label label-warning\">warning</span>" |

  @javascript
  Scenario Outline: Test block styles with one and two classes
    Given I log in as "admin"
    And I open my profile in edit mode
    And I set the field "Description" to <text>
    # No need to select the text in the Atto editor when testing block styles,
    # as they'll apply to everything if nothing is selected.
    And I click on "Show more buttons" "button"
    When I click on "Styles" "button"
    And I click on <style> "link"
    And I click on "HTML" "button"
    Then the field "Description" matches value <html>

    Examples:
      | text            | style           | html                                                 |
      | "i'm a hero"    | "Hero unit box" | "<div class=\"hero-unit\">i'm a hero</div>"          |
      | "help"          | "Muted Well"    | "<div class=\"well text-muted\">help</div>"          |
      | "I'm a h3"      | "Heading 3"     | "<h3 class=\"\">I'm a h3"                            |
