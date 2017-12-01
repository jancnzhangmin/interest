class RegionsController < ApplicationController
  before_action {authen "region"}
  def index

  end

  def shownodes

  end

  def showedit

  end

  def getnodes
    regions = Region.all

    regionarr = Array.new
    regions.each do |f|
      if f.up_id.to_s== "0" || f.up_id.to_s == ""
        regionclass = Regionclass.new
        regionclass.text = f.region
        regionclass.tags = f.id
        if f.childrens.count >0
          regionclass.nodes = createnodes(f.childrens)
        end
        regionarr.push regionclass
      end
    end

    # nodes = createnodes(farmclas)
    render json:  regionarr.to_json
  end

  def updatenodes
    if params[:way] == 'add'

      if Region.exists?(params[:selfid])
        region = Region.find(params[:selfid])
        if region.parent
          Region.create(region:params[:region],up_id:region.parent.id)
        else
          Region.create(region:params[:region])
        end
      else
        Region.create(region:params[:region])
      end
    elsif params[:way]=='ch'
      if Region.exists?(params[:selfid])
        Region.create(region:params[:region],up_id:params[:selfid])
      end
    elsif params[:way]== 'up'
      if Region.exists?(params[:selfid])
        if Region.find(params[:selfid]).parent.parent
          region = Region.find(params[:selfid]).parent.parent
          nowregion = Region.find(params[:selfid])
          nowregion.up_id = region.id
          nowregion.save
        else
          nowregion = Region.find(params[:selfid])
          nowregion.up_id = 0
          nowregion.save
        end
      end
    elsif params[:way]== 'down'
      if Region.exists?(params[:selfid]) &&  Region.exists?(params[:moveto])
        region = Region.find(params[:selfid])
        region.up_id = Region.find(params[:moveto]).id
        region.save
      end
    elsif params[:way]== 'edit'
      if Region.exists?(params[:selfid])
        region = Region.find(params[:selfid])
        region.region =params[:region]
        region.save
      end
    elsif params[:way] == 'del'

      region = Region.find(params[:selfid])
      del(region)
    end
  end


  private

  class Regionclass
    attr :text,true
    attr :nodes,true
    attr :tags,true
  end

  def createnodes(regions)
    regionarr = Array.new
    regions.each do |f|
      regionclass = Regionclass.new
      regionclass.text = f.region
      regionclass.tags = f.id
      if f.childrens.count>0
        regionclass.nodes = createnodes(f.childrens)
      end
      regionarr.push regionclass
    end
    return regionarr
  end

  def del(region)
    if region.childrens.count > 0
      region.childrens.each do |f|
        del(f)
      end
    end
    region.destroy

  end

end
