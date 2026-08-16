module CockpitHelper
  def skill_level_classes(level)
    base_classes =
      "flex min-h-16 min-w-20 flex-col items-center " \
      "justify-center rounded-lg border text-center"

    color_classes =
      case level
      when 5
        "border-indigo-800 bg-indigo-700 text-white"
      when 4
        "border-blue-700 bg-blue-600 text-white"
      when 3
        "border-sky-500 bg-sky-100 text-sky-950"
      when 2
        "border-amber-400 bg-amber-100 text-amber-950"
      when 1
        "border-orange-400 bg-orange-100 text-orange-950"
      when 0
        "border-slate-300 bg-slate-100 text-slate-600"
      else
        "border-dashed border-slate-300 bg-white text-slate-400"
      end

    "#{base_classes} #{color_classes}"
  end
end