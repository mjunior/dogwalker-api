class DogWalkingListQuery < BaseQuery
  def initialize params
    @relation = DogWalking.all
    @now = Time.now
    @all = params[:all] == 'true' ? true : false
    super(params)
  end
  
  def call
    result = without_past_walkings
    result = @relation if @all
    paginate(result)
  end
  
  private
  def without_past_walkings
    @relation.where('schedule_date >= ?', @now)
  end
end