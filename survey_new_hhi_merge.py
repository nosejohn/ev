import pandas as pd
survey = pd.read_csv('/Users/johnkim/Documents/R/ev/EV_0207.csv', index_col = False)

# Load the median household income data
median_hhi = pd.read_excel('/Users/johnkim/Documents/study/gatech/research/EV/median_hh_income.xlsx', usecols='A:Y')

# Rename the columns for clarity
median_hhi.columns = ['STATE'] + [str(i) for i in range(1, 24)]

median_hhi_long = pd.melt(median_hhi, id_vars=['STATE'], var_name='household_size', value_name='median_income')
median_hhi_long['household_size'] = median_hhi_long['household_size'].astype(int)

median_hhi_long_renamed = median_hhi_long.rename(columns={'STATE': 'inputstate', 'household_size': 'hhsize', 
                                                         'median_income': 'state_median_hhi'})

merged_df = pd.merge(survey, median_hhi_long_renamed, on=['inputstate', 'hhsize'])

def categorize_income(row):
    # Check if either value is NA (using pd.isna for compatibility with pandas NAs)
    if pd.isna(row['income_midpoint']) or row['income_midpoint'] == "NA":
        return 'Prefer_not_to_say'  # or any other designation you prefer for missing income data
    elif row['income_midpoint'] < 0.8 * row['state_median_hhi']:
        return 'Low'
    elif row['income_midpoint'] <= 1.2 * row['state_median_hhi']:
        return 'Mid'
    else:
        return 'High'

merged_df['new_hhi_cat'] = merged_df.apply(categorize_income, axis=1)

