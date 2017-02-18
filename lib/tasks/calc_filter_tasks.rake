desc 'calc filter'
task calc_filter: :environment do
  MainHelper.calc_best
  MainHelper.calc_hot
  ReviewLifeHelper.calc_best
  ReviewLifeHelper.calc_hot
  ReviewHousesHelper.calc_best
  ReviewHousesHelper.calc_hot
end

