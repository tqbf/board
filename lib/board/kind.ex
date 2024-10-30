defmodule Board.Kind do
  use Ecto.Schema
  import Ecto.Changeset

  schema "kinds" do
    field :kind, :string
    field :detail, :string
    timestamps()
  end

  def changeset(kind, attrs) do
    kind
    |> cast(attrs, [:kind, :detail])
    |> validate_required([:kind])
  end

  # calling into question why this is a model in the first place but w/ev

  @condensed25 %{
    PUB_WRK_ROADS: "Public Works",
    PUB_WRK_LIGHT: "Public Works",
    PUB_WRK_UTIL: "Public Works",
    PUB_WRK_PARK: "Parking",
    TRANS_INF_PARK: "Parking",
    TRANS_INF_TRAFFIC: "Parking",
    RACE_EQ_PROCL: "Racial Equity",
    RACE_EQ_COMM: "Racial Equity",
    RACE_EQ_POLIC: "Racial Equity",
    RACE_EQ_HOUS: "Racial Equity",
    AFF_HOUS_DEV: "Housing",
    AFF_HOUS_POL: "Housing",
    AFF_HOUS_REDEV: "Housing",
    AFF_HOUS_INC: "Housing",
    PUB_HLT_COVID: "Health",
    PUB_HLT_TOBAC: "Health",
    PUB_HLT_MENT: "Health",
    PUB_HLT_SERV: "Health",
    ENV_SUS_PLST: "Plastic & Waste",
    ENV_SUS_RECY: "Plastic & Waste",
    ENV_SUS_CLIM: "Climate & Energy",
    ENV_SUS_ENERGY: "Climate & Energy",
    SUS_ENE_SOLAR: "Climate & Energy",
    SUS_ENE_RENEW: "Climate & Energy",
    SUS_ENE_CARB: "Climate & Energy",
    PUB_SAFE_POLIC: "Safety",
    PUB_SAFE_FIRE: "Safety",
    PUB_SAFE_COMM: "Safety",
    PUB_SAFE_PENS: "Pensions",
    TRANS_INF_EXP: "Transportation",
    TRANS_INF_TRANS: "Transportation",
    FIN_MGT_BUDGET: "Fiscal Management",
    FIN_MGT_TAX: "Fiscal Management",
    FIN_MGT_AUDIT: "Fiscal Management",
    FIN_MGT_GRANTS: "Fiscal Management",
    ZONE_USE_COMM: "Zoning",
    ZONE_USE_RES: "Zoning",
    ZONE_USE_AMEND: "Zoning",
    ZONE_USE_PERMIT: "Zoning",
    ECON_DEV_INC: "Economic Development",
    ECON_DEV_REDEV: "Economic Development",
    ECON_DEV_COMM: "Economic Development",
    ECON_DEV_SALE: "Economic Development",
    PUB_ENG_HEAR: "Public Engagement",
    PUB_ENG_PROC: "Public Engagement",
    PUB_ENG_CITIZEN: "Public Engagement",
    PUB_ENG_MEET: "Public Engagement",
    SUS_ENE_BUILD: "Building Efficiency",
    PROC: "Procedural Rules",
    PROC_BOARD_RULES: "Procedural Rules",
    PROC_VILLAGE_RULES: "Procedural Rules",
    PROC_ORD_RULES: "Procedural Rules",
    PROC_PUBLIC_INPUT: "Procedural Rules",
    PROC_VILLAGE_POLICY: "Procedural Rules",
    PROC_ELECTIONS: "Election & Ethics",
    PROC_ETHICS: "Election & Ethics",
    PROC_TRANSPAR: "Election & Ethics",
    STAFF_MGMT_COMP: "Municipal Staffing",
    STAFF_MGMT_HIRE: "Municipal Staffing",
    STAFF_MGMT_REVIEW: "Municipal Staffing",
    STAFF_MGMT_UNION: "Municipal Staffing",
    AFF_HOUS_POL: "Housing",
    AFF_HOUS_INC: "Housing",
    OTHER: "Other"
  }

  @condensed10 %{
    PUB_WRK_ROADS: "Public Works",
    PUB_WRK_LIGHT: "Public Works",
    PUB_WRK_UTIL: "Public Works",
    PUB_WRK_PARK: "Public Works",
    TRANS_INF_PARK: "Public Works",
    TRANS_INF_TRAFFIC: "Public Works",
    TRANS_INF_EXP: "Public Works",
    TRANS_INF_TRANS: "Public Works",
    RACE_EQ_PROCL: "Equity",
    RACE_EQ_COMM: "Equity",
    RACE_EQ_POLIC: "Equity",
    RACE_EQ_HOUS: "Equity",
    AFF_HOUS_DEV: "Equity",
    AFF_HOUS_POL: "Equity",
    AFF_HOUS_REDEV: "Equity",
    AFF_HOUS_INC: "Equity",
    PUB_HLT_COVID: "Public Health",
    PUB_HLT_TOBAC: "Public Health",
    PUB_HLT_MENT: "Public Health",
    PUB_HLT_SERV: "Public Health",
    PUB_SAFE_POLIC: "Public Safety",
    PUB_SAFE_FIRE: "Public Safety",
    PUB_SAFE_COMM: "Public Safety",
    PUB_SAFE_PENS: "Public Safety",
    ENV_SUS_PLST: "Environmental Sustainability",
    ENV_SUS_RECY: "Environmental Sustainability",
    ENV_SUS_CLIM: "Environmental Sustainability",
    ENV_SUS_ENERGY: "Environmental Sustainability",
    SUS_ENE_SOLAR: "Environmental Sustainability",
    SUS_ENE_RENEW: "Environmental Sustainability",
    SUS_ENE_CARB: "Environmental Sustainability",
    SUS_ENE_BUILD: "Environmental Sustainability",
    FIN_MGT_BUDGET: "Fiscal Management & Governance",
    FIN_MGT_TAX: "Fiscal Management & Governance",
    FIN_MGT_AUDIT: "Fiscal Management & Governance",
    FIN_MGT_GRANTS: "Fiscal Management & Governance",
    PROC_BOARD_RULES: "Fiscal Management & Governance",
    PROC_VILLAGE_RULES: "Fiscal Management & Governance",
    PROC_ORD_RULES: "Fiscal Management & Governance",
    PROC_PUBLIC_INPUT: "Fiscal Management & Governance",
    PROC_VILLAGE_POLICY: "Fiscal Management & Governance",
    PROC_ELECTIONS: "Fiscal Management & Governance",
    PROC_ETHICS: "Fiscal Management & Governance",
    PROC_TRANSPAR: "Fiscal Management & Governance",
    ZONE_USE_COMM: "Zoning",
    ZONE_USE_RES: "Zoning",
    ZONE_USE_AMEND: "Zoning",
    ZONE_USE_PERMIT: "Zoning",
    ECON_DEV_INC: "Economic Development",
    ECON_DEV_REDEV: "Economic Development",
    ECON_DEV_COMM: "Economic Development",
    ECON_DEV_SALE: "Economic Development",
    PUB_ENG_HEAR: "Community Engagement",
    PUB_ENG_PROC: "Community Engagement",
    PUB_ENG_CITIZEN: "Community Engagement",
    PUB_ENG_MEET: "Community Engagement",
    STAFF_MGMT_COMP: "Staff & Personnel",
    STAFF_MGMT_HIRE: "Staff & Personnel",
    STAFF_MGMT_REVIEW: "Staff & Personnel",
    STAFF_MGMT_UNION: "Staff & Personnel",
    AFF_HOUS_POL: "Housing",
    AFF_HOUS_INC: "Housing",
    PROC: "Meeting Procedure",
    OTHER: "Other"
  }

  def con25, do: @condensed25
  def con10, do: @condensed10
  def con25k, do: Map.values(@condensed25) |> Enum.uniq()
  def con10k, do: Map.values(@condensed10) |> Enum.uniq()
end
