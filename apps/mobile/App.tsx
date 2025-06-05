import { StatusBar } from 'expo-status-bar';
import { StyleSheet, Text, View, SafeAreaView, ScrollView } from 'react-native';

export default function App() {
  return (
    <SafeAreaView style={styles.container}>
      <StatusBar style="auto" />
      <ScrollView contentContainerStyle={styles.scrollContent}>
        <View style={styles.header}>
          <Text style={styles.title}>Productivity Booster</Text>
          <Text style={styles.subtitle}>AI-powered deep work application</Text>
        </View>

        <View style={styles.statusCard}>
          <Text style={styles.cardTitle}>Platform Status</Text>
          
          <View style={styles.statusItem}>
            <Text style={styles.statusLabel}>Mobile App</Text>
            <View style={styles.statusBadgeSuccess}>
              <Text style={styles.statusBadgeText}>✓ Running</Text>
            </View>
          </View>

          <View style={styles.statusItem}>
            <Text style={styles.statusLabel}>Backend API</Text>
            <View style={styles.statusBadgeSuccess}>
              <Text style={styles.statusBadgeText}>✓ Running</Text>
            </View>
          </View>

          <View style={styles.statusItem}>
            <Text style={styles.statusLabel}>Web App</Text>
            <View style={styles.statusBadgeSuccess}>
              <Text style={styles.statusBadgeText}>✓ Running</Text>
            </View>
          </View>
        </View>

        <View style={styles.featuresGrid}>
          <View style={styles.featureCard}>
            <Text style={styles.featureTitle}>Cross-Platform</Text>
            <Text style={styles.featureDescription}>
              Works on web browsers, Android devices, and iPad
            </Text>
          </View>

          <View style={styles.featureCard}>
            <Text style={styles.featureTitle}>AI-Powered</Text>
            <Text style={styles.featureDescription}>
              Intelligent task management and behavioral coaching
            </Text>
          </View>

          <View style={styles.featureCard}>
            <Text style={styles.featureTitle}>Deep Work</Text>
            <Text style={styles.featureDescription}>
              Based on Cal Newport's proven focus principles
            </Text>
          </View>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f8fafc',
  },
  scrollContent: {
    padding: 20,
  },
  header: {
    alignItems: 'center',
    marginBottom: 32,
    marginTop: 20,
  },
  title: {
    fontSize: 32,
    fontWeight: 'bold',
    color: '#1e293b',
    marginBottom: 8,
    textAlign: 'center',
  },
  subtitle: {
    fontSize: 16,
    color: '#64748b',
    textAlign: 'center',
    lineHeight: 24,
  },
  statusCard: {
    backgroundColor: '#ffffff',
    borderRadius: 12,
    padding: 20,
    marginBottom: 24,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 8,
    elevation: 4,
  },
  cardTitle: {
    fontSize: 20,
    fontWeight: '600',
    color: '#1e293b',
    marginBottom: 16,
  },
  statusItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 12,
  },
  statusLabel: {
    fontSize: 16,
    color: '#64748b',
  },
  statusBadgeSuccess: {
    backgroundColor: '#dcfce7',
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 12,
  },
  statusBadgeText: {
    fontSize: 12,
    color: '#166534',
    fontWeight: '500',
  },
  featuresGrid: {
    gap: 16,
  },
  featureCard: {
    backgroundColor: '#ffffff',
    borderRadius: 12,
    padding: 20,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 8,
    elevation: 4,
  },
  featureTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#1e293b',
    marginBottom: 8,
  },
  featureDescription: {
    fontSize: 14,
    color: '#64748b',
    lineHeight: 20,
  },
});
