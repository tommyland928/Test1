class ApiController < ApplicationController
    def general
        member = Member.all
        render json: member
    end

    def rank
        person = Person.all
        render json: person
    end    

    def save

        #person.allのデータを更新
        if Person.exists? then
            person = Person.all
            person.each do |t|
                member = Member.find_by(name: t.name.to_s, group: t.group.to_s)
                if member != nil then
                    logger.debug("ここまで来てるよ")

                    tmp = member.score + t.score
                    logger.debug(tmp)
                    member.update(score: tmp)
                    if member.save
                    end
                end

            end
            Person.destroy_all
        else
        end


    end

    def delete
        if params[:id] != nil then
            person = Person.find_by(id: params[:id])
            person.delete
        else

        end
    end

    def sent
        if Person.find_by(id: params[:id]) == nil then
            member = Member.find_by(id: params[:id])
            person = Person.new(id: member.id, name: member.name, group: member.group, score: params[:score], send: params[:send])
            if person.save
            end
        else
            person = Person.find_by(id: params[:id])
            person.update(score: params[:score], send: params[:send])
            if person.save
            end
        end
    end

    def reset
        Person.destroy_all
    end





end
