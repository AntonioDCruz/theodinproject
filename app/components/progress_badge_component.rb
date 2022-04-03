class ProgressBadgeComponent < ViewComponent::Base
  delegate :user_signed_in?, :percentage_completed_by_user, to: :helpers

  def initialize(course:, current_user:, url:, modifier: '', radius: 70, stroke: 8)
    @course = course
    @current_user = current_user
    @modifier = modifier
    @url = url
    @radius = radius
    @stroke = stroke
  end

  private

  attr_reader :course, :current_user, :modifier, :url, :radius, :stroke

  def normalized_radius
    radius - stroke * 2
  end

  def circumference
    normalized_radius * 2 * Math::PI
  end

  def badge
    course_badges.fetch(course.title, 'icons/odin-icon.svg')
  end

  def borderless_badge
    borderless_badges.fetch(course.title, 'icons/odin-icon.svg')
  end

  # rubocop:disable Metrics/MethodLength
  def borderless_badges
    {
      'Foundations' => 'badges/badge-foundations-borderless.svg',
      'Intermediate HTML and CSS' => 'badges/badge-html-borderless.svg',
      'Advanced HTML and CSS' => 'badges/badge-html-borderless.svg',
      'Ruby' => 'badges/badge-ruby-borderless.svg',
      'JavaScript' => 'badges/badge-javascript-borderless.svg',
      'Ruby on Rails' => 'badges/badge-ruby-on-rails-borderless.svg',
      'Getting Hired' => 'badges/badge-getting-hired-borderless.svg',
      'Databases' => 'badges/badge-database-borderless.svg',
      'NodeJS' => 'badges/badge-nodejs-borderless.svg'
    }
  end

  def course_badges
    {
      'Foundations' => 'badge-foundations.svg',
      'Intermediate HTML and CSS' => 'badge-html-css.svg',
      'Advanced HTML and CSS' => 'badge-html-css.svg',
      'Ruby' => 'badge-ruby.svg',
      'JavaScript' => 'badge-javascript.svg',
      'Ruby on Rails' => 'badge-ruby-on-rails.svg',
      'Getting Hired' => 'badge-getting-hired.svg',
      'Databases' => 'badge-database.svg',
      'NodeJS' => 'badge-nodejs.svg'
    }
  end
  # rubocop:enable Metrics/MethodLength
end
