--否定ペンギン
function c32623004.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(32623004,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_F)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c32623004.spcon)
	e1:SetCost(c32623004.spcost)
	e1:SetTarget(c32623004.sptg)
	e1:SetOperation(c32623004.spop)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_TO_HAND_REDIRECT)
	e2:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
	e2:SetTarget(c32623004.rmtg)
	e2:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e2)
end
function c32623004.spcon(e,tp,eg,ep,ev,re,r,rp)
	return re:GetHandler():IsSetCard(0x5a)
end
function c32623004.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if Duel.GetFlagEffect(tp,32623005)~=0 then return false end
		Duel.RegisterFlagEffect(tp,32623005,RESET_CHAIN,0,1)
		return Duel.GetFlagEffect(tp,32623004)==0
	end
	Duel.RegisterFlagEffect(tp,32623004,RESET_PHASE+PHASE_END,0,1)
end
function c32623004.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c32623004.spop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
function c32623004.rmtg(e,c)
	return c:IsReason(REASON_EFFECT) and c:GetReasonEffect():GetHandler():IsSetCard(0x5a)
end
